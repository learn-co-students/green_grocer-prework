require 'pry'

def consolidate_cart(cart)
  cart.uniq.each_with_object({}) do |item,result|
    item.each do |name,hash|
      hash[:count] = cart.count(item)
      result[name] = hash
    end
  end
  # binding.pry
end

def apply_coupons(cart, coupons)
  # return cart if coupons.empty?
  coupons.each do |coupon|
    name = coupon[:item]
    w_c = "#{name} W/COUPON"
    if cart.keys.include?(name) && cart[name][:count] >= coupon[:num]
      cart[name][:count] -= coupon[:num]
      cart[w_c] ||= {}
      cart[w_c][:price] ||= coupon[:cost]
      cart[w_c][:clearance] ||= cart[name][:clearance]
      cart[w_c][:count] ||= 0
      cart[w_c][:count] += 1
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |item,hash|
    hash[:price] = hash[:price] - (hash[:price] * 0.2) if hash[:clearance]
  end
end

def checkout(cart, coupons)
  new_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  fin_cart = new_cart.map {|k,v| v[:price] * v[:count]}.reduce(0, :+)
  return fin_cart > 100 ? fin_cart -= (fin_cart * 0.1) : fin_cart 
end



def items
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}}
	]
end

consolidate_cart(items)

