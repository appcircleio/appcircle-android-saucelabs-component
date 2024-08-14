# frozen_string_literal: true

require 'English'
require 'net/http'
require 'json'
require 'base64'
require 'yaml'

def get_env(key)
  return (ENV[key] == nil || ENV[key] == "") ? nil : ENV[key]
end

def env_has_key(key)
  value = get_env(key)
  return value unless value.nil? || value.empty?

  abort("Input #{key} is missing.")
end

def run_command(command)
  puts "@@[command] #{command}"
  unless system(command)
    exit $?.exitstatus
  end
end

def abort_with1(message)
  puts "@@[error] #{message}"
  exit 1
end

def check_config_file(config_path)
  unless File.exist?(config_path)
    abort_with1("Sauce config file not found at #{config_path}")
  end
end

def auth_saucelabs(username, access_key)
  run_command('sudo npm install -g saucectl')
  puts "Saucectl version: #{run_command('saucectl -v')}"
  run_command("saucectl configure --username #{username} --accessKey #{access_key}")
end

def run_saucectl(params)
  command = "cd #{$repo_dir} && sudo saucectl run #{params.join(' ')}"
  puts "Running command: #{command}"
  run_command(command)
end

def check_suite_name(config_path, suite_name)
  config = YAML.load_file(config_path)

  unless config['suites'].find { |suite| suite['name'] == suite_name }
    available_suites = config['suites'].map { |suite| suite['name'] }
    abort_with1("Suite name '#{suite_name}' not found. Available suites: #{available_suites.join(', ')}")
  end
end

def add_parameter(command, flag, value)
  command << "#{flag}=#{value}" if value
end

def add_bool_parameter(command, flag, value)
  command << "#{flag}" if value=="true"
end

def export_sauce_artifacts(download_dir)
  if download_dir
      puts "Exporting downloaded sauce files..."
      run_command("cd $AC_OUTPUT_DIR && mkdir -p sauce && cp -r #{download_dir} sauce")
  else
    puts "Download artifacts direction not found for Sauce..."
  end
end

$repo_dir = env_has_key("AC_REPOSITORY_DIR")
sl_rel_config_path = env_has_key("AC_SL_CONFIG_PATH")
sl_config_path = sl_rel_config_path.nil? ? nil : File.join($repo_dir, sl_rel_config_path)
check_config_file(sl_config_path)
sl_username = env_has_key("AC_SL_USERNAME")
sl_access_key = env_has_key("AC_SL_ACCESS_KEY")
auth_saucelabs(sl_username, sl_access_key)
sl_run_only_via_config = get_env("AC_RUN_ONLY_VIA_CONFIG") || "false"
sl_select_suite = get_env("AC_SL_SELECT_SUITE")
check_suite_name(sl_config_path, sl_select_suite)
sl_rel_download_dir = get_env("AC_SL_DOWNLOAD_DIR")
sl_download_dir = sl_rel_download_dir.nil? ? nil : File.join($repo_dir, sl_rel_download_dir)

sl_params = []
add_parameter(sl_params, "--config", sl_config_path)
if sl_run_only_via_config == "true"
  puts "Only configuration file mode enabled. Running raw config file (#{sl_config_path})."
else
  add_parameter(sl_params, "--artifacts.cleanup", get_env("AC_SL_ARTIFACT_CLEANUP") || "false")
  add_parameter(sl_params, "--artifacts.download.directory", sl_download_dir)
  add_parameter(sl_params, "--artifacts.download.match", get_env("AC_SL_DOWNLOAD_MATCH"))
  add_parameter(sl_params, "--artifacts.download.when", get_env("AC_SL_WHEN_ARTIFACT_DOWNLOAD") || "never")
  add_bool_parameter(sl_params, "--async", get_env("AC_SL_ASYNC"))
  add_parameter(sl_params, "--build", get_env("AC_SL_BUILD"))
  add_parameter(sl_params, "--ccy", get_env("AC_SL_CCY"))
  add_parameter(sl_params, "--env", get_env("AC_SL_ENV"))
  add_bool_parameter(sl_params, "--fail-fast", get_env("AC_SL_FAIL_FAST"))
  add_bool_parameter(sl_params, "--live-logs", true)
  add_parameter(sl_params, "--region", env_has_key("AC_SL_REGION"))
  add_parameter(sl_params, "--retries", get_env("AC_SL_RETRIES"))
  add_parameter(sl_params, "--root-dir", get_env("AC_SL_ROOT_DIR"))
  add_parameter(sl_params, "--sauceignore", get_env("AC_SL_SAUCEIGNORE"))
  add_parameter(sl_params, "--select-suite", "`#{sl_select_suite}`")
  add_bool_parameter(sl_params, "--show-console-log", get_env("AC_SL_SHOW_CONSOLE_LOG"))
  add_parameter(sl_params, "--tags", get_env("AC_SL_TAGS"))
  add_parameter(sl_params, "--timeout", get_env("AC_SL_TIMEOUT"))
  add_parameter(sl_params, "--tunnel-name", get_env("AC_SL_TUNNEL_NAME"))
  add_parameter(sl_params, "--tunnel-owner",  get_env("AC_SL_TUNNEL_OWNER"))
  add_parameter(sl_params, "--tunnel-timeout", get_env("AC_SL_TUNNEL_TIMEOUT"))
end

run_saucectl(sl_params)
export_sauce_artifacts(sl_download_dir)