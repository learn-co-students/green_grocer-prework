def consolidate_cart(cart)
  # code here
  dens_cart = {}
  cart.each do |list|
    list.each do |key,data|
      if(dens_cart.keys.include?(key))
        dens_cart[key][:count] +=1
      else
        dens_cart[key] = data.merge(:count=>1)
      end #if
    end #list
  end#cart
  dens_cart
end

#{"AVOCADO" => {:price => 3.00, :clearance => true,:count=2}},
#{:item => "AVOCADO", :num => 2, :cost => 5.00},
def apply_coupons(cart, coupons)
  # code here
  coupons.each do |data|
    if(cart.has_key?(data[:item]))
      if (cart[data[:item]][:count] >= data[:num])
        t_name = "#{data[:item]} W/COUPON"
        if(cart.has_key?(t_name))
          cart[t_name][:count] +=1
        else
          cart[t_name] = {:price => 0.00, :clearance => true,:count=>0}
          cart[t_name][:price] = data[:cost]
          cart[t_name][:clearance] = cart[data[:item]][:clearance]
          cart[t_name][:count] =1
        end #if
        # puts cart[data[:item]]
        # puts cart[t_name]

        cart[data[:item]][:count] = cart[data[:item]][:count] - data[:num]
      end #if
    end #if
  end #coupons
  cart
end


#{"AVOCADO" => {:price => 3.00, :clearance => true,:count=2}},
def apply_clearance(cart)
  # code here

  cart.each do |key,data|
      #puts key, data
      temp = (data[:price] * 0.8).round(2)
      data[:price] = temp if(data[:clearance] == true)
  end
  cart
end

def checkout(cart, coupon = [])
  #puts cart
  total = 0.00
  cart1 = consolidate_cart(cart)
  cart1 = apply_coupons(cart1,coupon)
  cart1 = apply_clearance(cart1)
  #puts cart1
  cart1.each do |item, data|
    total = data[:price] * data[:count] + total
  end
  total = (total*0.9).round(2) if total >100
  total.round(2)
  # code here
end

items = 	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
    {"TEMPEH" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
coupons=
  	[
  		{:item => "AVOCADO", :num => 2, :cost => 5.00},
  		{:item => "BEER", :num => 2, :cost => 20.00},
  		{:item => "CHEESE", :num => 3, :cost => 15.00},
      {:item => "AVOCADO", :num => 2, :cost => 5.00}
  	]

puts checkout(items)
