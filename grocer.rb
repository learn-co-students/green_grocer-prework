require 'pry'

def consolidate_cart(cart)
  new_hash={}
  cart.each do |hash|
    hash.each do |item, details|
      hash[item][:count]=0
      cart.each do |hash2|
        hash2.each do |item2, details2|
          if item2 == item
            hash2[item2][:count]+=1
            new_hash[item2]=details2
          end
        end
      end
    end
  end
  new_hash
end




def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"].nil?
        cart["#{name} W/COUPON"]={:price => coupon[:cost], :clearance => cart[name][:clearance], :count => 1}
        cart[name][:count]-=coupon[:num]
      else
        cart["#{name} W/COUPON"][:count]+=1
        cart[name][:count]-=coupon[:num]
      end
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance] == true
      details[:price]-=details[:price]* 1/5
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart=consolidate_cart(cart)
  cart_w_coupons = apply_coupons(consolidated_cart, coupons)
  subtotal = apply_clearance(cart_w_coupons)
  total = 0
  subtotal.each do |item, details|
    total+=(details[:price]*details[:count])
  end
  if total > 100
    total=total-(total*1/10)
  else
    total
  end
end
