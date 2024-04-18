# The act-runner port for FreeBSD

The port will compile and install
[act-runner](https://gitea.com/gitea/act_runner) from source on FreeBSD.

## Notes

I haven't yet found a way to make it play nice with `GO_MODULES`, so it doesn't
download the dependencies properly before hand and won't work under poudriere.

If you know how to make this work, please send a pull request.
