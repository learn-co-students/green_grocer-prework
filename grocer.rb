require "pry"

def consolidate_cart(cart)
new_hash = {}

  cart.uniq.map do |x|
    x.map do |i,k| 
      k[:count] = cart.count(x)
        x.each do |t,p|
          new_hash[t] = p
        end    
    end
  end

new_hash
end


def apply_coupons(cart, coupons)

  coupons.each do |coup_name| 
  coupon_name = coup_name[:item]

  if cart[coupon_name] && cart[coupon_name][:count] >= coup_name[:num]
    if cart["#{coupon_name} W/COUPON"]
        cart["#{coupon_name} W/COUPON"][:count] += 1 
        else
          cart["#{coupon_name} W/COUPON"] = {:price => coup_name[:cost], :count => 1}
          cart["#{coupon_name} W/COUPON"][:clearance] = cart[coupon_name][:clearance]
    end  
        cart[coupon_name][:count] -= coup_name[:num]
  end
 end

cart
end

def apply_clearance(cart)
    cart.each do |i,k| 
    if k[:clearance]
      disc = k[:price] * 0.20
      k[:price] = k[:price] - disc
    end
  end 
  cart
end


def checkout(cart, coupons)

  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  total = 0
  clearance_applied.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  
  total = total * 0.9 if total > 100

  total

end
