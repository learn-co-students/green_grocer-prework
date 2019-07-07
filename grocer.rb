require 'pry'

def consolidate_cart(cart)
  newCart = Hash.new

  cart.each do |key|
    key.each do |key2, val2|
      #binding.pry
      if newCart.include?(key2)
        newCart[key2][:count] += 1
        #binding.pry
      else
        newCart[key2] = val2
        newCart[key2][:count] = 1
      end
    end
  end

  return newCart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    itemName = coupon[:item]
    if cart.include?(itemName)
      if cart[itemName][:count] >= coupon[:num]
        newItem = itemName + " W/COUPON"
        if cart.include?(newItem)
          cart[newItem][:count] += 1
          cart[itemName][:count] -= coupon[:num]
        else
          newItemData = {price: coupon[:cost], clearance: cart[itemName][:clearance], count: 1}
          cart[newItem] = newItemData
          cart[itemName][:count] -= coupon[:num]
          if cart[itemName][:count] < 0
            cart.delete(itemName)
          end
        end
      end
    end
  end

  return cart
end

def apply_clearance(cart)
  cart.each do |key, val|
    if val[:clearance] == true
      val[:price] = (val[:price] * 0.8).round(2)
    end
  end

  return cart
end

def checkout(cart, coupons)
  #binding.pry
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  #binding.pry
  cart = apply_clearance(cart)
  cart.each do |key, val|
    if val[:count] == 0
      cart.delete(key)
    end
  end

  total = 0.0
  cart.each do |item, val|
    #binding.pry
    count = val[:count]
    for i in 1..count
      total += val[:price]
    end
  end
  #binding.pry
  if total > 100
    total = (total * 0.9).round(2)
  end
  #binding.pry
  return total
end
