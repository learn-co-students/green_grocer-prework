require "pry"

def consolidate_cart(cart)
  cart_hash = {}
  cart.each {|item_hash|
    item_hash.each{|item, attribute_hash|
      if (cart_hash.keys.include? item)
        cart_hash[item][:count] += 1
      else
        cart_hash[item] = attribute_hash
        cart_hash[item][:count] = 1
      end
    }
  }
  cart_hash
end

def apply_coupons(cart, coupons)
  coupon_items_to_add = []
  coupons.each {|coupon_hash|
    apply_coupons_to = cart.select {|key, value| key == coupon_hash[:item]}
    apply_coupons_to.each {|cart_item_name, cart_item_attributes|
      if cart_item_attributes[:count] >= coupon_hash[:num]
        tentatively_add = {"#{cart_item_name} W/COUPON" => {:price => coupon_hash[:cost],:clearance => cart_item_attributes[:clearance],:count => 1}}
        tentatively_add_index = coupon_items_to_add.find_index(tentatively_add)
        if tentatively_add_index == nil
          coupon_items_to_add.push(tentatively_add)
        else
          coupon_items_to_add[tentatively_add_index]["#{cart_item_name} W/COUPON"][:count] += 1
        end
        cart[cart_item_name][:count] -= coupon_hash[:num]
      end
    }
  }
  coupon_items_to_add.each {|item|
    item.each {|key, value|
      cart[key] = value
    }
  }
  cart
end

def apply_clearance(cart)
  cart.each {|key, value|
    if value[:clearance] == true
      value[:price] *= 0.8
      value[:price] = value[:price].round(1)
    end
  }
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart_total = 0.0
  cart.each {|key, value|
    cart_total += (value[:price]*value[:count]).round(1)
  }
  cart_total = (cart_total*0.9).round(1) if cart_total > 100
  cart_total
end
