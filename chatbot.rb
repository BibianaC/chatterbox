require 'colorize'

ADD_KEY = 'When I say "(.*)" you should reply "(.*)"'

if File.exists?("out.txt")
	RESPONSES = Marshal.load(IO.read("out.txt"))
else
	RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
          	  'I hate (.*)' => 'I hate %{c1} too',
          	  'Have a nice day' => 'Thanks, you too',
          	  'I am crazy for (.*)' => 'Really? me too',
          	  'hello' => 'Hi',
          	  'See you (.*)' => 'See you %{c1}',
          	  'I am going to (.*)' => 'Ok. Enjoy',
          	  'My favorite language is (.*)' => 'I also like %{c1}',
          	  'My favorite cities are (.*), (.*) and (.*)' =>
          	  'I have never been in %{c1} and %{c2} but I have been in %{c3} and I also liked it a lot',
          	  ADD_KEY => 'Ok. I got that'
          	}
end

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.first
  /#{key}/ =~ input
  response = RESPONSES[key] 
  add_response($1, $2) if key == ADD_KEY
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3}
end

def add_response(question, answer)
  RESPONSES[question] = answer
    puts "It is added"
    str = Marshal.dump(RESPONSES)
    File.open("out.txt", "w") {|f| f.write(str) }
end

def introduction 
  puts "Bot: ".blue + "Hello, what's your name?"
  print "Person: ".red
  name = gets.chomp
  puts "Bot:".blue + "Hello #{name}"
  print "Person: ".red
end

def have_conversation 
  while(input = gets.chomp) do
    puts "Bot: ".blue + get_response(input)
    break if input == 'goodbye' || input == 'sayonara'
    print "Person: ".red
  end
end

introduction
have_conversation