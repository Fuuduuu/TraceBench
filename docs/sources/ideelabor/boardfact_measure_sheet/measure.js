/* ============================================================
   TraceBench · BoardFact — Kiire mõõtmisleht
   Measure-first technician flow. Read-only board, you add measurements.
   ============================================================ */
(function () {
  "use strict";

  // --------------------------------------------------------- Components (read-only projection)
  // kind: soic | sot5 | sot3 | chip | header
  const COMPONENTS = [
    { id: "U12", fam: "soic_8",     kind: "soic",   x: 196, y: 196, w: 104, h: 64, pins: 8, side: "pealmine", rot: "0°",  size: "4.9 × 3.9 mm", pitch: "1,27 mm", coord: "X 142 · Y 88", note: "Korpus 8-jalaga SOIC. Identiteet kinnitamata." },
    { id: "U3",  fam: "sot23_5",    kind: "sot5",   x: 388, y: 150, w: 44,  h: 28, pins: 5, side: "pealmine", rot: "90°", size: "2,9 × 1,6 mm", pitch: "0,95 mm", coord: "X 214 · Y 76", note: "5-jalaga SOT-23." },
    { id: "R14", fam: "chip_0603",  kind: "chip",   x: 168, y: 110, w: 40,  h: 18, pins: 2, side: "pealmine", rot: "0°",  size: "1,6 × 0,8 mm", pitch: "—",      coord: "X 96 · Y 52",  note: "Kiipkomponent 0603." },
    { id: "R22", fam: "chip_0603",  kind: "chip",   x: 170, y: 312, w: 40,  h: 18, pins: 2, side: "pealmine", rot: "0°",  size: "1,6 × 0,8 mm", pitch: "—",      coord: "X 98 · Y 168", note: "Kiipkomponent 0603." },
    { id: "C9",  fam: "chip_0805",  kind: "chip",   x: 330, y: 268, w: 48,  h: 24, pins: 2, side: "pealmine", rot: "0°",  size: "2,0 × 1,25 mm",pitch: "—",      coord: "X 178 · Y 142", note: "Kiipkondensaator 0805." },
    { id: "D2",  fam: "sot23_3",    kind: "sot3",   x: 412, y: 268, w: 36,  h: 24, pins: 3, side: "pealmine", rot: "0°",  size: "2,9 × 1,3 mm", pitch: "1,9 mm", coord: "X 222 · Y 144", note: "3-jalaga SOT-23." },
    { id: "Q1",  fam: "sot23_3",    kind: "sot3",   x: 322, y: 360, w: 36,  h: 24, pins: 3, side: "pealmine", rot: "0°",  size: "2,9 × 1,3 mm", pitch: "1,9 mm", coord: "X 174 · Y 196", note: "3-jalaga SOT-23." },
    { id: "J1",  fam: "header_1x6", kind: "header", x: 524, y: 168, w: 30,  h: 168,pins: 6, side: "pealmine", rot: "0°",  size: "2,54 mm samm", pitch: "2,54 mm",coord: "X 286 · Y 90",  note: "6-jalaline latt." },
  ];

  // --------------------------------------------------------- Pin geometry
  function pinCenters(c) {
    const out = [];
    if (c.kind === "soic") {
      const half = c.pins / 2;
      const step = c.h / half;
      for (let i = 0; i < half; i++) out.push({ n: i + 1, x: c.x - 7, y: c.y + step * (i + 0.5) });
      for (let i = 0; i < half; i++) out.push({ n: half + i + 1, x: c.x + c.w + 7, y: c.y + c.h - step * (i + 0.5) });
    } else if (c.kind === "chip") {
      out.push({ n: 1, x: c.x - 5, y: c.y + c.h / 2 });
      out.push({ n: 2, x: c.x + c.w + 5, y: c.y + c.h / 2 });
    } else if (c.kind === "sot3") {
      out.push({ n: 1, x: c.x + c.w * 0.25, y: c.y - 5 });
      out.push({ n: 2, x: c.x + c.w * 0.75, y: c.y - 5 });
      out.push({ n: 3, x: c.x + c.w / 2, y: c.y + c.h + 5 });
    } else if (c.kind === "sot5") {
      out.push({ n: 1, x: c.x + c.w * 0.2, y: c.y - 5 });
      out.push({ n: 2, x: c.x + c.w * 0.5, y: c.y - 5 });
      out.push({ n: 3, x: c.x + c.w * 0.8, y: c.y - 5 });
      out.push({ n: 4, x: c.x + c.w * 0.7, y: c.y + c.h + 5 });
      out.push({ n: 5, x: c.x + c.w * 0.3, y: c.y + c.h + 5 });
    } else if (c.kind === "header") {
      const step = c.h / c.pins;
      for (let i = 0; i < c.pins; i++) out.push({ n: i + 1, x: c.x + c.w / 2, y: c.y + step * (i + 0.5) });
    }
    return out;
  }

  // --------------------------------------------------------- State
  const LS = "boardfact_measure_v1";
  let state = {
    selected: "U12",
    armed: false,
    pin: 1,
    unit: "V",        // V | Ω | Diode | Beep
    value: "",
    beep: null,       // "pass" | "fail"
    measurements: {}, // { compId: [ {pin, unit, value, beep, t} ] }
    tech: false,
    techOpen: false,
    infoOpen: false,
    accent: "amber",
  };
  try {
    const saved = JSON.parse(localStorage.getItem(LS) || "null");
    if (saved) state = Object.assign(state, saved);
  } catch (e) {}
  function persist() {
    try { localStorage.setItem(LS, JSON.stringify(state)); } catch (e) {}
  }

  function comp(id) { return COMPONENTS.find((c) => c.id === id); }
  function listFor(id) { return state.measurements[id] || []; }

  // --------------------------------------------------------- SVG board
  const SVGNS = "http://www.w3.org/2000/svg";
  function el(tag, attrs, txt) {
    const n = document.createElementNS(SVGNS, tag);
    for (const k in attrs) n.setAttribute(k, attrs[k]);
    if (txt != null) n.textContent = txt;
    return n;
  }

  function drawBoard() {
    const svg = document.getElementById("board");
    svg.innerHTML = "";
    // board substrate
    const board = el("rect", { x: 80, y: 70, width: 540, height: 360, rx: 16,
      fill: "#0c1a1f", stroke: "var(--copper-soft)", "stroke-width": 1.2 });
    svg.appendChild(board);
    // faint copper grid
    for (let gy = 110; gy < 430; gy += 40) {
      svg.appendChild(el("line", { x1: 80, y1: gy, x2: 620, y2: gy,
        stroke: "var(--copper)", "stroke-width": 0.4, opacity: 0.10 }));
    }
    // mounting holes
    [[104, 94], [596, 94], [104, 406], [596, 406]].forEach(([cx, cy]) => {
      svg.appendChild(el("circle", { cx, cy, r: 7, fill: "#06100f", stroke: "var(--copper-dim)", "stroke-width": 1 }));
    });
    // silk title
    svg.appendChild(el("text", { x: 96, y: 90, "font-family": "var(--mono)", "font-size": 10,
      fill: "var(--silk-soft)", "letter-spacing": "0.1em", opacity: 0.6 }, "DEV_BOARD_A · REV C"));

    // decorative traces
    const tr = el("g", { stroke: "var(--copper)", "stroke-width": 1.6, fill: "none", opacity: 0.35 });
    ["180,150 250,150 250,228 300,228", "300,280 360,280 360,180 410,180",
     "210,320 300,320 300,372", "446,280 470,280 470,200 524,200"].forEach((p) =>
      tr.appendChild(el("polyline", { points: p })));
    svg.appendChild(tr);

    COMPONENTS.forEach((c) => svg.appendChild(drawComp(c)));
  }

  function drawComp(c) {
    const g = el("g", { class: "comp", "data-id": c.id, tabindex: 0, role: "button",
      "aria-label": c.id + " " + c.fam });
    const selected = c.id === state.selected;
    const ms = listFor(c.id);

    // selection ring
    if (selected) {
      g.appendChild(el("rect", { x: c.x - 12, y: c.y - 12, width: c.w + 24, height: c.h + 24, rx: 8,
        fill: "none", stroke: "var(--copper)", "stroke-width": 1.4, "stroke-dasharray": "5 4", opacity: 0.9 }));
    }

    // pads
    const pads = el("g", { fill: "var(--pad)" });
    pinCenters(c).forEach((p) => {
      if (c.kind === "header") {
        pads.appendChild(el("circle", { cx: p.x, cy: p.y, r: 4, fill: "var(--pad)" }));
      } else {
        pads.appendChild(el("rect", { x: p.x - 3.5, y: p.y - 3.5, width: 7, height: 7, rx: 1, fill: "var(--pad)" }));
      }
    });
    g.appendChild(pads);

    // body
    const bodyFill = c.id === "U12" ? "var(--body)" : (c.kind === "header" ? "#16242a" : "#243339");
    g.appendChild(el("rect", { class: "body-shape", x: c.x, y: c.y, width: c.w, height: c.h,
      rx: c.kind === "chip" ? 2 : 3, fill: bodyFill, stroke: "var(--silk)", "stroke-width": 1 }));
    // pin-1 dot
    if (c.kind === "soic" || c.kind === "sot5") {
      g.appendChild(el("circle", { cx: c.x + 7, cy: c.y + 7, r: 2.4, fill: "var(--silk)" }));
    }
    // designator
    const big = c.kind === "soic" || c.kind === "header";
    g.appendChild(el("text", {
      x: c.kind === "header" ? c.x - 8 : c.x + c.w / 2,
      y: c.kind === "header" ? c.y + c.h / 2 + 4 : c.y + c.h / 2 + 4,
      "text-anchor": c.kind === "header" ? "end" : "middle",
      "font-family": "var(--mono)", "font-size": big ? 13 : 9.5,
      fill: "var(--silk)" }, c.id));

    // measurement evidence dots on measured pins
    if (ms.length) {
      const centers = pinCenters(c);
      const measuredPins = new Set(ms.map((m) => m.pin));
      measuredPins.forEach((pn) => {
        const p = centers.find((x) => x.n === pn);
        if (p) {
          g.appendChild(el("circle", { cx: p.x, cy: p.y, r: 6, fill: "none",
            stroke: "var(--amber)", "stroke-width": 1.4, opacity: 0.9 }));
          g.appendChild(el("circle", { cx: p.x, cy: p.y, r: 2.4, fill: "var(--amber)" }));
        }
      });
    }
    // active-pin marker when measuring this component
    if (selected && state.armed) {
      const p = pinCenters(c).find((x) => x.n === state.pin);
      if (p) {
        g.appendChild(el("circle", { cx: p.x, cy: p.y, r: 9, fill: "none",
          stroke: "var(--amber)", "stroke-width": 1.6 }));
      }
    }

    // hit area
    g.appendChild(el("rect", { class: "hit", x: c.x - 14, y: c.y - 14, width: c.w + 28, height: c.h + 28 }));

    g.addEventListener("click", () => selectComp(c.id));
    g.addEventListener("keydown", (e) => { if (e.key === "Enter" || e.key === " ") { e.preventDefault(); selectComp(c.id); } });
    return g;
  }

  function selectComp(id) {
    if (state.selected === id) return;
    state.selected = id;
    state.armed = false;
    state.pin = 1;
    state.value = "";
    state.beep = null;
    persist();
    renderAll();
  }

  // --------------------------------------------------------- Inspector / sheet
  const UNITS = [
    { id: "V", label: "V", sub: "pinge" },
    { id: "Ω", label: "Ω", sub: "takistus" },
    { id: "Diode", label: "Diode", sub: "U_f" },
    { id: "Beep", label: "Beep", sub: "pidevus" },
  ];

  function unitSuffix(u) {
    return u === "V" ? "V" : u === "Ω" ? "Ω" : u === "Diode" ? "V" : "";
  }

  function nextPin(c) {
    // auto-suggest: first pin without a measurement, else pin 1
    const measured = new Set(listFor(c.id).map((m) => m.pin));
    const all = pinCenters(c).map((p) => p.n);
    const free = all.find((n) => !measured.has(n));
    return free || all[0];
  }

  function renderInspector() {
    const c = comp(state.selected);
    const ms = listFor(c.id);

    document.getElementById("desig").textContent = c.id;
    document.getElementById("fam").innerHTML = c.fam + " &nbsp;<em>·</em>&nbsp; " + c.pins + " jalga";

    // measure button
    const btn = document.getElementById("btnMeasure");
    btn.classList.toggle("armed", state.armed);
    btn.querySelector(".lbl").textContent = state.armed ? "Mõõdan…" : "Mõõda";

    // sheet
    const sheet = document.getElementById("sheet");
    sheet.classList.toggle("open", state.armed);
    if (state.armed) renderSheet(c);

    // measurement list
    renderMeasurements(c, ms);
    // collapsibles
    renderInfo(c);
    renderTech(c);
    // step label
    document.getElementById("step").textContent = c.id + " · jalg " + state.pin;
  }

  function renderSheet(c) {
    // Koht
    document.getElementById("kohtComp").textContent = c.id;
    document.getElementById("kohtPin").textContent = "jalg " + state.pin;

    // pin chips
    const pr = document.getElementById("pinRow");
    pr.innerHTML = "";
    const measured = new Set(listFor(c.id).map((m) => m.pin));
    pinCenters(c).forEach((p) => {
      const b = document.createElement("button");
      b.className = "pin-chip" + (p.n === state.pin ? " active" : "") + (measured.has(p.n) ? " has-m" : "");
      b.textContent = p.n;
      b.addEventListener("click", () => { state.pin = p.n; persist(); renderInspector(); focusValue(); });
      pr.appendChild(b);
    });

    // value vs beep
    const isBeep = state.unit === "Beep";
    document.getElementById("valueWrap").style.display = isBeep ? "none" : "block";
    document.getElementById("beepWrap").style.display = isBeep ? "block" : "none";

    // suffix + uf tag
    document.getElementById("suffix").textContent = unitSuffix(state.unit);
    document.getElementById("ufTag").style.display = state.unit === "Diode" ? "block" : "none";

    const vi = document.getElementById("valueInput");
    if (vi.value !== state.value) vi.value = state.value;
    vi.placeholder = state.unit === "Ω" ? "0,00" : state.unit === "Diode" ? "0,000" : "0,00";

    // beep buttons
    document.getElementById("beepPass").classList.toggle("sel-pass", state.beep === "pass");
    document.getElementById("beepFail").classList.toggle("sel-fail", state.beep === "fail");

    // unit chips
    const ur = document.getElementById("unitRow");
    ur.innerHTML = "";
    UNITS.forEach((u) => {
      const b = document.createElement("button");
      b.className = "unit-chip" + (u.id === state.unit ? " active" : "");
      b.textContent = u.label;
      b.title = u.sub;
      b.addEventListener("click", () => {
        state.unit = u.id;
        state.beep = null;
        persist();
        renderInspector();
        if (u.id !== "Beep") focusValue();
      });
      ur.appendChild(b);
    });

    // save enabled?
    updateSaveState();
  }

  function updateSaveState() {
    const btn = document.getElementById("btnSave");
    const ready = state.unit === "Beep" ? !!state.beep : state.value.trim() !== "";
    btn.disabled = !ready;
  }

  function focusValue() {
    if (state.unit === "Beep") return;
    requestAnimationFrame(() => {
      const vi = document.getElementById("valueInput");
      if (vi && document.getElementById("sheet").classList.contains("open")) {
        vi.focus(); vi.select && vi.select();
      }
    });
  }

  function arm() {
    const c = comp(state.selected);
    state.armed = true;
    state.pin = nextPin(c);       // Koht (automaatne)
    state.value = "";
    if (state.unit === "Beep") state.beep = null;
    persist();
    renderAll();
    focusValue();                  // Väärtus (auto-fookus)
  }

  function save() {
    const c = comp(state.selected);
    const ready = state.unit === "Beep" ? !!state.beep : state.value.trim() !== "";
    if (!ready) return;
    const rec = {
      pin: state.pin,
      unit: state.unit,
      value: state.unit === "Beep" ? null : state.value.trim(),
      beep: state.unit === "Beep" ? state.beep : null,
      t: Date.now(),
    };
    if (!state.measurements[c.id]) state.measurements[c.id] = [];
    state.measurements[c.id].unshift(rec);
    // reset for next, advance pin (measure-first momentum)
    state.value = "";
    state.beep = null;
    state.pin = nextPin(c);
    persist();
    renderAll();
    toast(state.unit === "Beep" ? "Pidevus salvestatud" : "Mõõtmine salvestatud");
    focusValue();
  }

  // --------------------------------------------------------- Measurement list
  function fmtTime(t) {
    const d = new Date(t);
    const hh = String(d.getHours()).padStart(2, "0");
    const mm = String(d.getMinutes()).padStart(2, "0");
    return hh + ":" + mm;
  }
  function fmtRead(m) {
    if (m.unit === "Beep") return m.beep === "pass" ? "Läbib" : "Ei läbi";
    return m.value + " " + unitSuffix(m.unit);
  }
  function renderMeasurements(c, ms) {
    document.getElementById("mCount").textContent = ms.length;
    const wrap = document.getElementById("mList");
    const empty = document.getElementById("mEmpty");
    wrap.innerHTML = "";
    if (!ms.length) { empty.style.display = "block"; return; }
    empty.style.display = "none";
    ms.forEach((m) => {
      const row = document.createElement("div");
      row.className = "m-row";
      const readCls = m.unit === "Beep" ? (m.beep === "pass" ? " pass" : " fail") : "";
      const kind = m.unit === "Beep" ? "pidevus" : m.unit === "Diode" ? "diood" : m.unit === "Ω" ? "takistus" : "pinge";
      row.innerHTML =
        '<span class="dot"></span>' +
        '<span class="loc">' + c.id + ' · <b>jalg ' + m.pin + '</b></span>' +
        '<span class="read' + readCls + '">' + fmtRead(m) + "</span>" +
        '<span class="meta"><span class="kind">' + kind + '</span><span>' + fmtTime(m.t) + "</span></span>";
      wrap.appendChild(row);
    });
  }

  // --------------------------------------------------------- Collapsibles
  function renderInfo(c) {
    const wrap = document.getElementById("infoBody");
    wrap.innerHTML =
      kv("Korpus", c.fam.replace("_", "-").toUpperCase()) +
      kv("Jalgade arv", c.pins) +
      kv("Pool", c.side) +
      kv("Identiteet", '<span class="muted">kinnitamata</span>') +
      kv("Märkmed", c.note);
    document.getElementById("infoCol").classList.toggle("open", state.infoOpen);
  }
  function renderTech(c) {
    const col = document.getElementById("techCol");
    col.classList.toggle("tech-on", state.tech);
    col.classList.toggle("open", state.tech && state.techOpen);
    const wrap = document.getElementById("techBody");
    if (!state.tech) {
      wrap.innerHTML = '<div class="tech-off-note">Tehnilised detailid on välja lülitatud. Lülita ülal sisse, et näha korpuse mõõtmeid ja paigutust.</div>';
      return;
    }
    wrap.innerHTML =
      kv("Korpuse mõõt", c.size) +
      kv("Jala samm", c.pitch) +
      kv("Pööre", c.rot) +
      kv("Asukoht plaadil", "<code>" + c.coord + "</code>") +
      kv("Pool", c.side);
  }
  function kv(k, v) {
    return '<div class="kv"><div class="k">' + k + '</div><div class="v">' + v + "</div></div>";
  }

  // --------------------------------------------------------- Toast
  let toastTimer;
  function toast(msg) {
    const t = document.getElementById("toast");
    t.querySelector(".tmsg").textContent = msg;
    t.classList.add("show");
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => t.classList.remove("show"), 1600);
  }

  // --------------------------------------------------------- Render all
  function renderAll() {
    drawBoard();
    renderInspector();
  }

  // --------------------------------------------------------- Wire events
  function wire() {
    document.getElementById("btnMeasure").addEventListener("click", () => {
      if (state.armed) { focusValue(); return; }
      arm();
    });
    document.getElementById("btnSave").addEventListener("click", save);

    const vi = document.getElementById("valueInput");
    vi.addEventListener("input", (e) => {
      state.value = e.target.value.replace(/[^0-9.,kKmMµuΩ\- ]/g, "");
      if (e.target.value !== state.value) e.target.value = state.value;
      persist(); updateSaveState();
    });
    vi.addEventListener("keydown", (e) => { if (e.key === "Enter") { e.preventDefault(); save(); } });

    document.getElementById("beepPass").addEventListener("click", () => { state.beep = state.beep === "pass" ? null : "pass"; persist(); renderInspector(); });
    document.getElementById("beepFail").addEventListener("click", () => { state.beep = state.beep === "fail" ? null : "fail"; persist(); renderInspector(); });

    document.getElementById("infoHead").addEventListener("click", () => { state.infoOpen = !state.infoOpen; persist(); renderInfo(comp(state.selected)); });
    document.getElementById("techHead").addEventListener("click", (e) => {
      // clicking the switch toggles tech on/off; clicking row toggles open
      if (e.target.closest(".switch")) {
        state.tech = !state.tech;
        state.techOpen = state.tech;       // turning on reveals; off hides
      } else {
        if (!state.tech) { state.tech = true; state.techOpen = true; }
        else state.techOpen = !state.techOpen;
      }
      persist(); renderTech(comp(state.selected));
    });

    document.getElementById("btnReset").addEventListener("click", () => {
      state.measurements = {};
      state.armed = false; state.value = ""; state.beep = null;
      persist(); renderAll();
      toast("Näidisandmed lähtestatud");
    });
  }

  document.addEventListener("DOMContentLoaded", () => { wire(); renderAll(); });
})();
