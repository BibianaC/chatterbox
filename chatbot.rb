require 'colorize'

ADD_KEY = 'When I say "(.*)" you should reply "(.*)"'

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  if key == ADD_KEY
  	RESPONSES[$1] = $2
  	puts "It is added"
  end
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3}
end

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

puts "Bot: ".blue + "Hello, what's your name?"
print "Person: ".red
name = gets.chomp
puts "Bot:".blue + "Hello #{name}"
print "Person: ".red
while(input = gets.chomp) do
  puts "Bot: ".blue + get_response(input)
  if input == 'goodbye' || input == 'sayonara'
  	break
  else
  	print "Person: ".red
  end
end