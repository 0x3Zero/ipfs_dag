use eyre::Result;
use marine_rs_sdk::marine;

#[marine]
pub struct IpfsDagResult {
    pub success: bool,
    pub error: String,
    pub cid: String,
}

impl From<Result<String>> for IpfsDagResult {
    fn from(result: Result<String>) -> Self {
        match result {
            Ok(cid) => Self {
                success: true,
                error: "".to_string(),
                cid,
            },
            Err(err) => Self {
                success: false,
                error: err.to_string(),
                cid: "".to_string(),
            },
        }
    }
}
