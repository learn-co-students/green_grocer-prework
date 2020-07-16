def consolidate_cart(cart)
  # code here
  consolidatedCart = {}

  cart.each do |vegetableHash|
    currentVegetable = vegetableHash.keys[0]
    currentVegetableDetails = vegetableHash.values[0]
    if consolidatedCart[currentVegetable]
      consolidatedCart[currentVegetable][:count] +=1
    else
      consolidatedCart[currentVegetable] = currentVegetableDetails
      consolidatedCart[currentVegetable][:count] = 1
    end
  end
  return consolidatedCart
end

def apply_coupons(cart, coupons)
  cartWithCoupons = {}
  cart.each do |vegetable, details |
    coupons.each do |coupon|
      if vegetable == coupon[:item]
        couponNumber = details[:count]/coupon[:num]
        nonCouponNumber = details[:count]%coupon[:num]
        if couponNumber > 0
          cartWithCoupons["#{vegetable} W/COUPON"] = {
            :price => coupon[:cost],
            :clearance => details[:clearance],
            :count => couponNumber
          }
        end
        cartWithCoupons[vegetable] = {
          :price => details[:price],
          :clearance => details[:clearance],
          :count => nonCouponNumber
        }
      end
    end
    cartWithCoupons[vegetable] ||= details
  end
  return cartWithCoupons
end

def apply_clearance(cart)
  newCart = {}
  cart.each do |k, v|
    newCart[k] = {
      :price=> v[:clearance] ? v[:price] - (v[:price]*0.2) : v[:price],
      :clearance=> v[:clearance],
      :count=> v[:count]
    }
  end
  return newCart
end

def checkout(cart, coupons)
  total = 0
  superCart = consolidate_cart(cart)
  superCart = apply_coupons(superCart, coupons)
  superCart = apply_clearance(superCart)
  superCart.each do |_, v|
    total += v[:price] * v[:count]
  end
  total = total - total*0.1 if total > 100
  return total
end
