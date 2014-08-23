
Pry::Commands.command ">>", "highlight string output", :shellwords => false do |*args|
  require 'json'
  require 'nokogiri'

  opts = Slop.parse!(args) do |opt|
    opt.banner unindent <<-BANNER
      Usage: >> [ -t <type>] <optional ruby code>
    BANNER
    opt.on :h, :help do
      puts opt.help
    end
    opt.on :t, :type=
  end
  next if opts[:h]

  value = target.eval args.join(" ").sub(/\A *\z/, '_')
  type = opts[:t] ? opts[:t].to_sym : nil


  begin
    value = value.to_str
  rescue NoMethodError
    Pry.config.print.call(output, value) unless value.respond_to?(:to_str)
    next
  end


  if type == :json || !type && value.start_with?("{") || value.start_with?("[")
    begin
      value = JSON.pretty_generate(JSON.parse(value))
      type = :json
    rescue Pry::RescuableException => e
      output.puts "#{e}"
    end
  elsif type == :html || !type && value.start_with?("<html")
    begin
      value = Nokogiri::HTML(value).to_xhtml.lines.drop(1).join
      type = :html
    rescue Pry::RescuableException => e
      output.puts "#{e}"
    end
  elsif type == :xml || !type && value.start_with?("<")
    begin
      value = Nokogiri::XML(value).to_xml
      type = :xml
    rescue Pry::RescuableException => e
      output.puts "#{e}"
    end
  elsif !type
    if _pry_.respond_to?(:valid_expression?) && _pry_.valid_expression?(value) ||
      _pry_.respond_to?(:complete_expression?) && (begin _pry_.complete_expression?(value); true; rescue SyntaxError; false; end)
      type = :ruby
    end
  end

  if type
    output.puts CodeRay.scan(value, type).term
  elsif String === value
    output.puts value
  end
end

Pry::Commands.alias_command "highlight", ">>"
