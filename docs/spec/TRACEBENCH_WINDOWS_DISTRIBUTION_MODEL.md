# BenchBeep Windows Distribution Model

## Purpose and ownership

This specification is the durable owner of BenchBeep's supported Windows
desktop distribution model. It defines the product and architecture contract
for owning the Python runtime and the Python tooling/resources used by
accepted local product flows.

It does not select an installer technology, bundled-runtime artifact, support
manifest format, signing mechanism, update mechanism, or exact implementation
allowlist. Those choices require a separately scoped implementation cycle.

## Distribution decision

BenchBeep's first supported packaged desktop target is a standalone Windows
desktop application. A production release includes an application-owned,
version-pinned, offline support bundle containing:

- a private Python runtime; and
- the Python tools and runtime resources required by supported product flows.

The support bundle is part of the BenchBeep release. Its runtime, tools, and
resources are versioned with that release rather than discovered from the
user's development environment.

## User contract

A supported Windows installation must satisfy all of these requirements:

- a normal user does not install or configure Python;
- a normal user does not need a TraceBench source checkout;
- a normal user does not launch BenchBeep from a repository root;
- supported product behavior does not depend on process current working
  directory or a PATH-selected Python executable; and
- accepted local product flows continue to work without network access after
  installation.

## Production runtime ownership

Production builds must use the app-owned private Python runtime. Production
tool and resource paths must be absolute paths resolved from an app-owned
installed support root.

Production runtime selection must not:

- use `Directory.current` or process CWD to identify the support root;
- probe `py`, `python3`, `python`, or another arbitrary system command as a
  silent fallback; or
- require a source-tree-relative `tools/` path.

The application-owned runtime and support content are tied to the BenchBeep
build/release. A missing, corrupt, incompatible, or incomplete support bundle
must fail explicitly and safely; it must not fall through to an uncontrolled
system Python.

## Development and test boundary

Dependency injection and explicit developer overrides may remain available
for tests and repository development. Development may deliberately point to a
source checkout or a developer-selected runtime when that choice is explicit.

Those overrides are not the supported end-user distribution contract. They
must not weaken deterministic production runtime and support-root selection.

## Tool semantics and protected boundaries

The existing Python materializer, exporter, validator, and accepted writer
behavior remain canonical for this distribution decision. Packaging them does
not authorize a semantic rewrite.

This decision does not:

- port the Python tools to Dart;
- change event, schema, canonical-fact, writer, validator, materializer,
  projection, or Project ZIP semantics;
- change confirmation, evidence, idempotency, append, or readback behavior;
  or
- authorize a runtime-tool rewrite.

Any later semantic change remains subject to its existing canonical owner and
protected-surface process.

## Offline and supply-chain boundary

The supported product must not download Python, tools, or required runtime
resources on first run or during normal runtime. The release process must
eventually define and verify the complete support bundle.

A later implementation decision must cover:

- the exact bundled Python artifact and version;
- the exact tool/resource manifest and dependency closure;
- installed support-root discovery;
- integrity and signing verification;
- installer and update behavior;
- explicit missing/corrupt-bundle failure behavior; and
- applicable Python and bundled-dependency licenses and notices.

## Platform boundary

Windows desktop is the first supported packaged target for this contract.
Mobile behavior is outside this decision. This specification does not decide
macOS or Linux packaging.

## Rejected supported-product models

The following are not supported BenchBeep product distribution models:

1. **System Python required** — machine-dependent and not standalone.
2. **Source checkout required** — a developer environment is not a product
   distribution.
3. **Download runtime on first run** — violates the offline and deterministic
   product contract.
4. **Port all Python to Dart now** — an unnecessary broad semantic rewrite for
   this remediation; existing accepted tool behavior stays closed.
