require '/Users/katycarr/.rvm/gems/ruby-2.3.3/gems/readingtime-0.4.0/lib/readingtime'

class Timer
  def get_time(text)
    text.reading_time(:format => :approx)
  end

end
