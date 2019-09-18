def consolidate_cart(cart)
    consolidated = {}
    
    cart.each do |items|
        items.each do |item, info|
            if consolidated[item] == nil
                consolidated[item] = info
                consolidated[item][:count] = 1
            else
                consolidated[item][:count] += 1
            end
        end
    end
    
    consolidated
end

def apply_coupons(cart, coupons)
    cart.each do |item, info|
        coupons.each do |coupon|
            if coupon[:item] == item && cart["#{item} W/COUPON"] == nil && cart[item][:count] >= coupon[:num]
                num_applied = coupon[:num]
                cart[item][:count] -= num_applied
                cart = cart.clone
                cart["#{item} W/COUPON"] = {
                    price: coupon[:cost],
                    clearance: cart[item][:clearance],
                    count: 1
                }
            elsif coupon[:item] == item && cart[item][:count] >= coupon[:num]
                num_applied = coupon[:num]
                cart[item][:count] -= num_applied
                cart["#{item} W/COUPON"][:count] += 1
            end
        end
    end
    
    cart
end

def apply_clearance(cart)
    cart.each do |item, info|
        if info[:clearance] == true
            new_price = info[:price] * 0.80
            info[:price] = new_price.round(2)
        end
    end
    
    cart
end

def checkout(cart, coupons)
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    
    total = 0
  
    cart.each do |item, info|
        total += info[:price] * info[:count]
    end
    
    if total > 100
        total *= 0.90
    end
    
    total
end

