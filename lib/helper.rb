require_relative './json_client'

def run(url) 
  node = JSONClient.query(url)

  while !node.end?
    puts "#{node.message}, so accessing #{node.follow}"
    sleep(0.1)
    node = JSONClient.query(node.follow)
  end

  puts node.message
  puts node.follow

  return node
end
