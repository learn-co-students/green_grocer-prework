require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |name, attributes|
      consolidated_cart[name] = attributes
      consolidated_cart[name][:count] = cart.count { |x| x == item }
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.collect do |item_hash|
    if cart.key?(item_hash[:item])
      if cart["#{item_hash[:item]} W/COUPON"]
        cart["#{item_hash[:item]} W/COUPON"][:count] += 1
      else
        cart["#{item_hash[:item]} W/COUPON"] = {:price => item_hash[:cost],
        :clearance => cart[item_hash[:item]][:clearance], :count => 1}
      end
      cart[item_hash[:item]][:count] = cart[item_hash[:item]][:count] - item_hash[:num]
    end
  end
  cart
end

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

def apply_clearance(cart)
  cart.collect do |item, attributes|
    if attributes[:clearance] == true
      attributes[:price] = ((attributes[:price] * (4.0 / 5.0)).round(2))
    end
    binding.pry
    cart
  end
  
end

def checkout(cart, coupons)
  # code here
end