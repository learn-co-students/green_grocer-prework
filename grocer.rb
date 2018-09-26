require 'pry'

def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each do |products|
    products.each do |product, product_data|
      if !new_hash.has_key?(product)
        new_hash[product] = product_data
        new_hash[product][:count] = 0
      end
      new_hash[product][:count] += 1
    end
  end 
  new_hash
 
end

def apply_coupons(cart, coupons)
  # code here
  new_hash = {}
  cart.each do |product, product_data|
    coupons.each do |coupon|
      if coupon[:item] == product && product_data[:count] >= coupon[:num]
        if !new_hash.has_key?("#{product} W/COUPON")
          new_hash["#{product} W/COUPON"] = {
            price: coupon[:cost],
            clearance: product_data[:clearance],
            count: 0
          }
        end
        new_hash["#{product} W/COUPON"][:count] += 1
        product_data[:count] -= coupon[:num]
      end 
    end 
  end 
  cart.merge(new_hash)
end

def apply_clearance(cart)
  # code here
  cart.each do |product, product_data|
    if product_data[:clearance] == true 
      product_data[:price] = (product_data[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0 
  cart.each do |product, product_data|
    total = total + (product_data[:price] * product_data[:count])
  end 
  
  if total > 100
    total = (total * 0.9).round(2)
  end 
  total
end


