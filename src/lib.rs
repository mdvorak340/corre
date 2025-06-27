use regex::Regex;
use subprocess::{Exec, PopenError};

fn regex_safe(not_safe: &str) -> String {
    let mut safe = String::new();

    for char in not_safe.chars() {
        safe.push('\\');
        safe.push(char);
    }

    safe
}

fn make_regex_pattern(opening_tag: &str, closing_tag: &str) -> Regex {
    Regex::new(
        format!(
            "(?ms){}(.*?){}",
            regex_safe(opening_tag),
            regex_safe(closing_tag),
        )
        .as_str(),
    )
    .unwrap()
}

fn exec_script(script: &str) -> Result<String, PopenError> {
    Ok({ Exec::shell(script) }
        .capture()?
        .stdout_str()
        .trim_ascii()
        .to_owned())
}

pub fn run_embedded_scripts(
    text: String,
    opening_tag: &str,
    closing_tag: &str,
) -> Result<String, PopenError> {
    let pattern = make_regex_pattern(opening_tag, closing_tag);

    if let Some(needle) = pattern.find(&text) {
        let mut before = text[..needle.start()].to_owned();
        let after = &text[needle.end()..];
        let script = &text[needle.start() + opening_tag.len()..needle.end() - closing_tag.len()];

        let mut script_result = exec_script(script)?;
        script_result.push_str(after);
        let rest = run_embedded_scripts(script_result, opening_tag, closing_tag)?;
        before.push_str(&rest);

        Ok(before)
    } else {
        Ok(text)
    }
}
