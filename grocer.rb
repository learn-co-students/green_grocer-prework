def consolidate_cart(cart)
  out = {}
  cart.each do |itemhash|
    itemhash.each do |item, info|
      if out[item] == nil
        out[item] = info
        out[item][:count] = 1
      else
        out[item][:count] += 1
      end
    end
  end
  out
end

def apply_coupons(cart, coupons)
  if coupons != []
    coupons.each do |coupon|
      if cart[coupon[:item]] != nil
        if cart[coupon[:item]][:count] >= coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
          if cart["#{coupon[:item]} W/COUPON"] == nil
            cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost],
                                                  :clearance => cart[coupon[:item]][:clearance], 
                                                  :count => 1}
          else
            cart["#{coupon[:item]} W/COUPON"][:count] += 1
          end
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = info[:price]*0.8
      info[:price] = info[:price].round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
 

  couponcart = apply_coupons(cart, coupons)
  clearancecart = apply_clearance(couponcart)
  
  total = 0
  
  clearancecart.each do |item, info|
    total += info[:price]*info[:count]
  end
  if total >= 100
    total = total*0.9
  end
  total.round(2)
end