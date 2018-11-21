require 'pry'
def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |element|
    element.each do |item, parameters|
        cart_hash[item] = parameters
        cart_hash[item][:count] ||= 0
          element.each do |count_item, count_parameters|
            if item == count_item
              cart_hash[item][:count] += 1
            end
          end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  #cart_hash = {}
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost], :clearance => cart[name][:clearance]}
        #cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end 
      cart[name][:count] -= coupon[:num]
    end 
  # The commented version below is my first attempt, works for single coupons but not multiples
  #cart.each do |item, parameters|
    #parameters.each do |parameter, value|
      # cart_hash[item] = parameters
      # coupons.each do |element|
      #   element.each do |coupon_parameter, coupon_value|
      #     if element[:item] == item
      #       cart_hash["#{item} W/COUPON"] = {}
      #       cart_hash["#{item} W/COUPON"][:price] = element[:cost]
      #       cart_hash["#{item} W/COUPON"][:count] = 1
      #       cart_hash["#{item} W/COUPON"][:clearance] = cart_hash[item][:clearance]
      #       if element[:num] != 0
      #         cart_hash[item][:count] -= element[:num]
      #         element[:num] = 0
      #       end
      #     end
      #   end
      # end 
    #end 
  end
  #binding.pry
  #cart_hash
  cart
end

def apply_clearance(cart)
  cart.each do |item, parameters|
      if parameters[:clearance] == true
        parameters[:price] = (parameters[:price] * 0.8).round(2)
      end
  end 
  cart
end

def checkout(cart, coupons)
  consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  
end
