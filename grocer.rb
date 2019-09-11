def consolidate_cart(cart)
    cart_count ={}
    cart.each do |item|
        name = item.keys[0]
        if !cart_count.has_key?(name)
            cart_count[name] = item.values[0]
            cart_count[name][:count] = 1
        else
            cart_count[name][:count] += 1
        end
    end
    cart_count
end

def apply_coupons(cart, coupons)
    coupons.each do |item|
        name = item[:item]
        if cart.has_key?(name) and !cart.has_key?(name + ' W/COUPON')
            
            cart[name + ' W/COUPON'] = {price:item[:cost], clearance:cart[name][:clearance], count:cart[name][:count] / item[:num]}
            cart[name][:count] %= item[:num]
        end
    end
    cart
end

def apply_clearance(cart)
    cart.each do |name, data|
        if data[:clearance]
            data[:price] *= 0.8
            data[:price] = data[:price].round(2)
        end
    end
end

def checkout(cart, coupons)
    cart = consolidate_cart(cart)
    apply_coupons(cart, coupons)
    apply_clearance(cart)
    total = 0.0
    cart.each {|item, data| total += data[:price] * data[:count]}
    if total > 100
        total *= 0.9
    end
    total
end
