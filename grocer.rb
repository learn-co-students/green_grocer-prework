require "pry"

def consolidate_cart(cart)
  cartOld = cart
  cartNew = {}
  cart.each do |item|
    #Count occurences in cart
    item[item.keys[0]][:count] = cartOld.find_all {|x| x == item}.size
    
    #Add to consolidated cart if not in there
    if cartNew[item.keys[0]].nil?
      cartNew[item.keys[0]] = item.values[0]
    end
  end
  cartNew
end

def apply_coupons(cart, coupons)
  cart
  coupons.each do |coupon|
    itemName = coupon[:item]
    if cart.keys.include?(itemName)
      itemPrice = coupon[:cost]
      itemNum = coupon[:num]
      newItemName = "#{itemName} W/COUPON"
      
      if (cart[itemName][:count] - itemNum) >= 0
        cart[itemName][:count] -= itemNum
        #New Cart
        if cart[newItemName].nil?
          cart[newItemName] = {}
          cart[newItemName][:count] = 0
        end
        cart[newItemName][:price] = itemPrice
        cart[newItemName][:clearance] = cart[itemName][:clearance]
        cart[newItemName][:count] += 1
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, values|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  sum = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item, value|
    sum += (cart[item][:price] * cart[item][:count])
  end
  if sum > 100
    sum *= 0.9
  else
    sum
  end
end
