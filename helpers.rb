#Haml::Options.defaults[:remove_whitespace] = true

def render(file)
    ext  = File.extname file
    file = File.basename file, ext if ext == '.haml'

    dir = File.dirname __FILE__
    path = File.expand_path "src/haml/#{file}.haml", dir

    Haml::Engine.new(File.read path).render
end
