module Mpd

  def self.stop(command)
    matching = command.match(/^stop\s+(mpd|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "mpc stop",
        :explanation => "stops playing mpd."
      }
    else
      nil
    end
  end

  def self.start(command)
    matching = command.match(/^(start|resume|play)\s+(mpd|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "mpc play",
        :explanation => "starts playing mpd."
      }
    else
      nil
    end
  end

  def self.pause(command)
    matching = command.match(/^pause\s+(mpd|((?:the|my)\s+)?music)$/i)

    if matching
      {
        :command => "mpc pause",
        :explanation => "pauses mpd."
      }
    else
      nil
    end
  end

  def self.next(command)
    matching = command.match(/^(next|advance)\s+(song|music|track|mpd)$/i)

    if matching
      {
        :command => "mpc next",
        :explanation => "makes mpd play the next track."
      }
    else
      nil
    end
  end

  def self.prev(command)
    matching = command.match(/^prev(?:ious)?\s+(song|music|track|mpd)$/i)

    if matching
      {
        :command => "mpc prev",
        :explanation => "makes mpd play the previous track."
      }
    else
      nil
    end
  end

  def self.playing(command)
    matching = command.match(/^what\'?s?\s+((songs?|musics?|tracks?|mpd)\s+)?(is)?\s?play(?:ing)?$/i)

    if matching
      {
        :command => "mpc current",
        :explanation => "gets the name of the playing track on mpd."
      }
    else
      nil
    end
  end

  def self.interpret(command)
    responses = []

    stop_command = self.stop(command)
    responses << stop_command if stop_command

    start_command = self.start(command)
    responses << start_command if start_command

    pause_command = self.pause(command)
    responses << pause_command if pause_command

    next_command = self.next(command)
    responses << next_command if next_command

    prev_command = self.prev(command)
    responses << prev_command if prev_command

    playing_command = self.playing(command)
    responses << playing_command if playing_command

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Mpd",
      :description => 'control \033[34mMpd\033[0m',
      :usage => ["pause mpd (requires mpd to be running)",
      "resume mpd (requires mpd to be running)",
      "stop mpd (requires mpd to be running)",
      "next mpd (requires mpd to be running)",
      "prev mpd (requires mpd to be running)",
      "whats mpd playing (requires mpd to be running)"]
    }
    commands
  end
end

$executors << Mpd

