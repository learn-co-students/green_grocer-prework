def consolidate_cart(cart)
  # code here
  result_cart = {}
  
  cart.each_with_index do |item, i|
    item.each do |food, info|
      if result_cart[food]
        result_cart[food][:count] += 1
      else
        result_cart[food] = info
        result_cart[food][:count] = 1
      end
    end
  end
  
  result_cart
end

def apply_coupons(cart, coupons)
  # code here
  result_cart = {}
  
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] = info[:count] - coupon[:num]
        
        if result_cart["#{food} W/COUPON"]
          result_cart["#{food} W/COUPON"][:count] += 1
        else
          result_cart["#{food} W/COUPON"] = {
            :price => coupon[:cost],
            :clearance => info[:clearance],
            :count => 1
          }
        end
      end
    end
    result_cart[food] = info
  end
  result_cart
end

def apply_clearance(cart)
  # code here
  clearance_cart = {}
  
  cart.each do |food, info|
    clearance_cart[food] = {}
    if info[:clearance] == true
      clearance_cart[food][:price] = info[:price] * 4/5
    else
      clearance_cart[food][:price] = info[:price]
    end
    
    clearance_cart[food][:clearance] = info[:clearance]
    clearance_cart[food][:count] = info[:count]
  end
  
  clearance_cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  result = 0
  
  cart.each do |food, info|
    result += (info[:price] * info[:count]).to_f
  end
  
  if result > 100
    result = result * 0.9
  end
  
  result
end
