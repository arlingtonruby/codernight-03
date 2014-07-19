class CaveFileParser

  def self.parse(file)
    data = File.read(file).split "\n"
    [data[0].to_i, data.slice(2..-1)]
  end

end