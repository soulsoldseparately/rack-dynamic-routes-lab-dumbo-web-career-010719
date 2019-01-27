#require_relative '../item.rb'

class Application

  @@items=[Item.new("Figs",3.42), Item.new("Pears",0.99)]
  def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path.match(/items/)
        name = req.path.split("/items/").last
        if qobj = @@items.find{|item| item.name == name}
          resp.write qobj.price
        else
          resp.write "Item not found"
          resp.status = 400
        end
      else
        resp.write "Route not found"
        resp.status = 404
      end
      resp.finish
  end
end
