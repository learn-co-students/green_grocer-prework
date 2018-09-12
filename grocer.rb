
def consolidate_cart(cart)
  hash = {}
  cart.each do |item_hash|
    item_hash.each do |name, price_hash|
      if hash[name].nil?
        hash[name] = price_hash.merge({:count => 1})
      else
        hash[name][:count] += 1
      end
    end
  end
  hash
end 
  

  def apply_coupons(cart, coupons)
  if coupons.length == 0
    return cart
  else
    coupons.each do |index|
      name = index[:item]
      item = cart[name]

      if(item != nil)
        if(item[:count] >= index[:num])
          item[:count] = item[:count] - index[:num]
          couponkey = "#{name} W/COUPON"
          if(cart[couponkey] == nill)
            couponitem = {:price => index[:cost], :clearance => item[:clearance], :count => 1}
            cart[couponkey] = couponitem
          else
            couponitem = cart[couponkey];
            couponitem[:count] +=1;
          end
        end
      end
    end
   end
  cart
end



def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end



def checkout(cart = [], coupons = [])
  cart = consolidate_cart(cart)
  cart_total = 0 

  if cart.length == 1 
    cart = apply_coupons(cart,coupons)
    apply_clearance(cart) 

    if cart.length > 1 
      cart.each do |name, info|
        if info[:count] < 1
          next 
        else 
          cart_total += info[:price]*info[:count]
        end 
      end
    else
      cart.each do |name, info|
        if info[:count] > 1
          cart_total+= info[:price]*info[:count]
        else 
          cart_total+= info[:price]
        end 
      end
    end 
  else  
    cart = apply_coupons(cart,coupons)
    cart = apply_clearance(cart)
    cart.each do |name, info|
      if info[:count] > 0 
        cart_total += info[:price]
      end 
    end 
  end 
      if cart_total < 100 
      return cart_total
    else 
      return cart_total - (cart_total*0.1)
    end 
  
end


