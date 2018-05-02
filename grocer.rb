require 'pry'

def consolidate_cart(cart)
  # code here
  consol_cart = {}
  cart.each do |item|
    item.each do |name, stats|

      if !consol_cart.has_key?(name)
        consol_cart[name]=stats
        consol_cart[name][:count] = 1
      else
        consol_cart[name][:count] += 1
      end #conditional statement
    end #item iteration
  end #cart iteration
  #binding.pry
  consol_cart
end #method

=begin
def apply_coupons(cart, coupons)
  # code here
  #binding.pry
  coupon_cart = {}
  cart.each do |item|
    item.each do |name,stats|
      binding.pry
      if coupons[0][:item] == name
        puts name
      end #conditonal statement
    end #item iteration
  end #cart iteration
end #method
=end

def apply_clearance(cart)
  # code here
  clear_cart = cart
  clear_cart.each do |item, attributes|


      binding.pry
      if attributes[:clearance] == true
        attributes[:price] = (attributes[:price].to_f * (0.8)).round(2)
      else
        attributes[:price] = attributes[:price]
      end


  end
  binding.pry
  clear_cart
end

def checkout(cart, coupons)
  # code here
end
