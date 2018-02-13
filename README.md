# ci-buildpack-cached

Pipeline which create cached buildpack from cloud foundry and deploy it to storage system (default to s3) when a new version of buildpack has been released.

## Use it on your concourse

**The default pipeline use an s3 on aws as the storage system, see [customize](#customize) section to use different system**

1. clone this repo
2. Create a `creds.yml` with this content

```yml
s3_bucket: my_s3_bucket
s3_access_key_id: my-s3-access-key-id
s3_secret_access_key: my-s3-access-key
github-access-token: my-github-token # this is needed only for java buildpack which has different build system
```
3. Log to concourse (e.g.: `fly -t target login -c https://my.concourse.ci/`)
4. Send the pipeline: `fly -t target set-pipeline -c pipeline.yml -p cached-buildpacks-creation -l creds.yml`
5. Unpause it: `fly -t target up -p cached-buildpacks-creation`

## Customize

There is some operators files which has been provided for this pipeline.

To use them, you will need the [bosh cli v2](https://bosh.io/docs/cli-v2.html) for its command `interpolate`.

### Add slack notification

Add notification about failure and success when a deploy has been triggered.

**Command**: `bosh interpolate pipeline.yml -o operators/slack-notify.yml`

**Credentials**:
- `slack-hook-url`: The webhook URL as provided by Slack or Mattermost.

### Use a custom s3

Use a different s3 endpoint to send your cached buildpack (default on AWS S3).

**Command**: `bosh interpolate pipeline.yml -o operators/custom-s3.yml`

**Credentials**:
- `s3_endpoint`: New s3 endpoint.

### Use artifactory as the storage system

Use artifactory instead of s3 to store your cached buildpack.

**Command**: `bosh interpolate pipeline.yml -o operators/artifactory.yml`

**Credentials**:
- `artifactory-url`: Url to Artifactory.
- `artifactory-username`: Artifactory username to push your buildpack.
- `artifactory-password`: Artifactory password to push your buildpack.

