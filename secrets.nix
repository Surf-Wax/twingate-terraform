# secrets.nix
# This is where you will input your twingate information, including API Key
# NOTE: if this file is not encrypted or otherwise protected,
#  theese variables are plaintext and need to be handled carefully
# These values will be exported into environment variables: see flake.nix
{
  twingateApiKey = "";
  twingateNetwork = "";
  twingateRemoteNetwork = "";
  twingateUserId = "";
}
