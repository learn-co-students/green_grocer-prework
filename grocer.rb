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
 counts = Hash.new(0)
  coupons.each do  |name| 
    counts[name[:item]] += 1 
  end  

  coupons.each do |coup_name| 
  if cart.keys.include?(coup_name[:item]) && cart[coup_name[:item]][:count] >= coup_name[:num]
    new_name = "#{coup_name[:item]} W/COUPON"
    cart[new_name] = {:price => coup_name[:cost], :clearance => cart[coup_name[:item]][:clearance], :count => counts[coup_name[:item]]}
    
      cart[coup_name[:item]][:count] = cart[coup_name[:item]][:count] - coup_name[:num]
      new_name = ''
      else
    return cart
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
  
  total > 100 ? total * 0.9 : total
end
