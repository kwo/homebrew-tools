class OpencodeService < Formula
  desc "Homebrew service wrapper for running opencode web mode"
  homepage "https://opencode.ai"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.2.10.tgz"
  sha256 "af65444345ce74d83f709f0f1f6d0679e2420a774aeb03b143d9c59364cf2628"
  license "MIT"

  depends_on :macos
  depends_on "opencode"

  def default_env
    <<~EOS
      # Environment for #{name}. Loaded by #{opt_bin}/opencode-service
      OPENCODE_PORT=4096
      OPENCODE_HOSTNAME=127.0.0.1
      # OPENCODE_PROJECT_DIR=/path/to/project
      # OPENCODE_MODEL=openai/gpt-5
      # OPENCODE_AGENT=default
      # Comma-separated domains passed to repeated --cors flags
      # OPENCODE_CORS=http://localhost:3000,http://127.0.0.1:5173
    EOS
  end

  def install
    (libexec/"opencode-service").write <<~BASH
      #!/bin/bash
      set -euo pipefail

      env_file="#{etc}/opencode-service.env"
      if [[ -f "${env_file}" ]]; then
        set -a
        # shellcheck disable=SC1090
        source "${env_file}"
        set +a
      fi

      : "${OPENCODE_PORT:=4096}"
      : "${OPENCODE_HOSTNAME:=127.0.0.1}"
      : "${OPENCODE_PROJECT_DIR:=${HOME}}"

      args=(web --hostname "${OPENCODE_HOSTNAME}" --port "${OPENCODE_PORT}")

      if [[ -n "${OPENCODE_MODEL:-}" ]]; then
        args+=(--model "${OPENCODE_MODEL}")
      fi

      if [[ -n "${OPENCODE_AGENT:-}" ]]; then
        args+=(--agent "${OPENCODE_AGENT}")
      fi

      if [[ -n "${OPENCODE_CORS:-}" ]]; then
        IFS=',' read -r -a cors_domains <<< "${OPENCODE_CORS}"
        for domain in "${cors_domains[@]}"; do
          [[ -n "${domain}" ]] && args+=(--cors "${domain}")
        done
      fi

      if [[ "${1:-}" == "--print-cmd" ]]; then
        printf '%q ' "#{Formula["opencode"].opt_bin}/opencode" "${args[@]}"
        printf '\n'
        exit 0
      fi

      cd "${OPENCODE_PROJECT_DIR}"
      exec "#{Formula["opencode"].opt_bin}/opencode" "${args[@]}"
    BASH

    chmod 0755, libexec/"opencode-service"
    bin.install_symlink libexec/"opencode-service"
    (pkgshare/"opencode-service.env.example").write default_env
  end

  def post_install
    env_file = etc/"opencode-service.env"
    return if env_file.exist?

    env_file.write default_env
  end

  service do
    run [opt_bin/"opencode-service"]
    keep_alive true
    log_path var/"log/opencode-service.log"
    error_log_path var/"log/opencode-service.err.log"
  end

  def caveats
    <<~EOS
      Configure #{etc}/opencode-service.env, then start the service:

        brew services start #{name}

      Logs:

        tail -f #{var}/log/opencode-service.log
        tail -f #{var}/log/opencode-service.err.log
    EOS
  end

  test do
    output = shell_output("#{bin}/opencode-service --print-cmd")
    assert_match Formula["opencode"].opt_bin/"opencode", output
    assert_match "--port", output
  end
end
