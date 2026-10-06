# Runta Harbor Runner

Run Terminal Bench 2.1 on Runta with the Harbor oracle agent.
The oracle agent executes the reference solutions supplied with the dataset.

## Run the evaluation

1. Install `uv`.
2. Set `RUNTA_TOKEN`, or save your Runta credentials in `~/.config/runta/config.toml`.
3. Run this command:

   ```sh
   ./run-eval.sh
   ```

The script uses `uv` to run Harbor with Runta support.
It permits a maximum of 256 trials at the same time.
Each environment has 32 GiB of disk space.

Harbor saves results and execution logs in `jobs/`.
Each evaluation has a separate directory.
The oracle agent does not produce model conversation records.

## Evaluation results

The evaluation on October 6, 2026 completed all 89 tasks.
**84 tasks passed. Five tasks failed.**
Harbor recorded no trial errors.
A failed task has a test reward of zero.
A trial error is a separate error recorded by Harbor.

See the [results](jobs/2026-10-06__14-37-48/result.json) and the [configuration](jobs/2026-10-06__14-37-48/config.json).
The configuration records this dataset reference:

```text
terminal-bench/terminal-bench-2-1
sha256:7d7bdc1cbedad549fc1140404bd4dc45e5fd0ea7c4186773687d177ad3a0699a
```

The configuration does not record the Harbor package version.
The script does not specify a Harbor version or a dataset reference hash.
Thus, a new evaluation can use different software or dataset content.

## Terminal Bench 2.1 task failures

The evidence indicates problems in the dataset environments, dependencies, and reference solutions.
It does not indicate a Runta runtime failure.

| Task | Cause | Evidence and correction status |
| --- | --- | --- |
| `qemu-startup` | An expired Debian security index causes HTTP 404 errors. The verifier cannot install `curl` and run `uvx`. | [Test log](jobs/2026-10-06__14-37-48/qemu-startup__qyoscdo/verifier/test-stdout.txt). Related report: [issue #233](https://github.com/harbor-framework/terminal-bench-2-1/issues/233). |
| `qemu-alpine-ssh` | The same Debian security index problem prevents verifier setup. | [Test log](jobs/2026-10-06__14-37-48/qemu-alpine-ssh__xoXZumv/verifier/test-stdout.txt). Related report: [issue #233](https://github.com/harbor-framework/terminal-bench-2-1/issues/233). |
| `mcmc-sampling-stan` | The environment does not have `cmake`. Installation of `RcppParallel` and RStan fails. The reference solution cannot create the required files. | [Oracle log](jobs/2026-10-06__14-37-48/mcmc-sampling-stan__EmuNja4/agent/oracle.txt). The [corrected task passed](jobs/mcmc-sampling-stan-syntax-patched-2026-10-06/result.json). |
| `build-cython-ext` | A dependency incompatibility is suspected. The extensions compile, but one repository test fails. | [Test log](jobs/2026-10-06__14-37-48/build-cython-ext__RQsiBwU/verifier/test-stdout.txt). Possible related report: [issue #240](https://github.com/harbor-framework/terminal-bench-2-1/issues/240). |
| `protein-assembly` | The reference solution ignores `non_standard_monomer` annotations. Unknown amino acids prevent DNA optimization. The solution does not create `gblock.txt`. | [Oracle log](jobs/2026-10-06__14-37-48/protein-assembly__rPGEVPE/agent/oracle.txt). The [corrected task passed](jobs/protein-assembly-patched-2026-10-06/result.json). |
