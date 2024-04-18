# The act-runner port for FreeBSD

The port will compile and install
[act-runner](https://gitea.com/gitea/act_runner) from source on FreeBSD.

## Building

1. Download to the `devel/act-runner` path in your ports tree.
1. Run `make package`.
1. `pkg add work/pkg/act-runner-*.pkg`.

## Notes

I haven't yet found a way to make it play nice with `GO_MODULES`, so it doesn't
download the dependencies properly before hand and won't build under poudriere.

If you know how to make poudriere builds work, please send a pull request or
throw ideas into an issue.
