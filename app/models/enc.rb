class Enc
  def self.cipher pass, text
    cipher = Gibberish::AES.new(pass)
    cipher.enc(text)
  end

  def self.decipher passes, text
    passes = Array passes
    attempts = passes.map{| pass| trydecipher(pass, text)}
    attempts.compact.first || "Error deciphering, invalid pass?"
  end

  def self.trydecipher pass, text
    begin
      cipher = Gibberish::AES.new(pass)
      return cipher.dec(text) 
    rescue
    end
  end
end