module OS

  def self.platform_name
    os = "unknown os"

    case RUBY_PLATFORM
      when /cygwin|mswin|mingw|bccwin|wince|emx/
        os = "windows"
      when /darwin/
        os = "os x"
      when /freebsd/
        os = "freebsd"
      when /openbsd/
        os = "openbsd"
      when /netbsd/
        os = "netbsd"
      when /linux/
        os = "linux"
    end

    os
  end

  def self.interpret(command)
    responses = []

    if command.match(/^(?:show|me|whats|what|is|my|\s)*OS(?:\s|name|do i have|is used|.)*$/i)
      os = platform_name

      responses << {
        :command => "echo '#{os}'",
        :explanation => "show what os is used"
      }
    end
    
    if command.match(/^(?:show|me|whats|what|is|my|\s)*kernel(?:\s|name|do i have|is used|.)*$/i)
      os = platform_name

      responses << {
        :command => "uname -a",
        :explanation => "show what os is used"
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "OS",
      :description => 'show \033[34mOS\033[0m name',
      :usage => ["show what os is used"]
    }
    commands
  end
end

$executors << OS
