def consolidate_cart(cart)
  cartHash = {}
  cart.each do
    |itemHash|
    itemHash.each do
      |item, itemProfileHash|
      if cartHash.key?(item) == false
        cartHash[item] = itemProfileHash
        cartHash[item][:count] = 1
      else
        cartHash[item][:count] += 1
      end
    end
  end

  return cartHash
end

#Coupon Array: [{:item => "AVOCADO", :num => 2, :cost => 5.0}]
def apply_coupons(cart, coupons)
  if coupons.length == 0
    return cart
  end
    hashCount = []
    newCart = {}
    coupons.each do
      |couponHash|
     couponItem = couponHash[:item]
     couponNum = couponHash[:num]
     couponCost = couponHash[:cost]
     cart.each do
       |item, itemHash|
       newCart[item] = itemHash
       if item == couponItem && hashCount.include?(item) == false && itemHash[:count] >= couponNum
         hashCount << item
         newCart["#{item} W/COUPON"] = {}
         newCart["#{item} W/COUPON"][:price] = couponCost
         newCart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
         newCart["#{item} W/COUPON"][:count] = 1
         itemHash[:count] = ((cart[item][:count] - couponNum).to_i)
       elsif item == couponItem && hashCount.include?(item) == false && itemHash[:count] < couponNum
         hashCount << item
         newCart["#{item} W/COUPON"] = {}
         newCart["#{item} W/COUPON"][:price] = couponCost
         newCart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
         newCart["#{item} W/COUPON"][:count] = 0
       elsif item == couponItem && itemHash[:count] >= couponNum && hashCount.include?(item)
         newCart["#{item} W/COUPON"][:count] += 1
         newCart[item][:count] = ((cart[item][:count] - couponNum).to_i)
       end
     end
   end
  return newCart
end

def apply_clearance(cart)
  cart.each do
    |item, itemHash|
    if itemHash[:clearance] == true
      itemHash[:price] *= 80
      itemHash[:price] /= 100
    end
  end

  return cart
end

def checkout(cart, coupons)
  newCart = consolidate_cart(cart)
  newCart = apply_coupons(newCart, coupons)
  newCart = apply_clearance(newCart)
  total = 0
  newCart.each do
    |item, itemHash|
    cost = itemHash[:price] *= itemHash[:count]
    total += cost
  end

  if total >= 100
    total *= 90
    total /= 100
    return total
  else
    return total
  end
end
