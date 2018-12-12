require "pry"

def consolidate_cart(cart)
  count_h = {}
  cart.each do |a|
    a.each do |k, v|
      if !count_h.key?(k)
        count_h[k] = {:count => 1}
      else
        count_h[k][:count] += 1
      end
    end
  end
  cart.each do |a|
    a.each do |k, v|
      v.each do |m, n|
        count_h.each do |c, d|
          if k == c
            count_h[c][m] = n
          end
        end
      end
    end
  end
  cart = count_h
  cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  if coupons.length == 0
    new_cart = cart
  else
    fun_hash = []
    coupons.each do |x|
      cart.each do |a, b|
        new_cart[a] = b
        if a == x[:item] && b[:count] >= x[:num]
          w_coup = "#{a} W/COUPON"
          if !fun_hash.include?(a)
            fun_hash << a
            new_cart[w_coup] = {}
            new_cart[w_coup][:price] = x[:cost]
            new_cart[w_coup][:clearance] = b[:clearance]
            new_cart[w_coup][:count] = 1
            b[:count] = ((b[:count] - x[:num]).to_i)
          elsif fun_hash.include?(a)
            new_cart[w_coup][:count] += 1
            new_cart[a][:count] = ((b[:count] - x[:num]).to_i)
          end
        end
      end
    end
  end
  cart = new_cart
  cart
end


def apply_clearance(cart)
  cart.each do |a, b|
    if b[:clearance] == true
      new_p = (b[:price] * 0.8).round(2)
      b[:price] = new_p
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |a, b|
    sub = b[:price] * b[:count]
    total += sub
  end
  if total > 100
    total *= 0.9
  end
  total
end
