require "pry"

def consolidate_cart(cart)
  hash = {}
  cart.each{|element|
    element.each{ |prod, p_hash|
      # binding.pry
      if hash[prod] == nil
        hash[prod] = p_hash
        hash[prod][:count] = 1
      else
        hash[prod][:count] += 1
      end
    }
  }
  hash
end

def apply_coupons(cart, coupons)
  # cart = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>5}}
  # coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0},{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
  array = []
  cart.each{ |prod, p_hash|
    coupons.each {|coupon|
      if prod == coupon[:item] && p_hash[:count] >= coupon[:num]
        array << prod + " W/COUPON"
        array << coupon[:cost]
        array << p_hash[:clearance]
        array << 1 #p_hash[:count] / coupon[:num]
        p_hash[:count] = p_hash[:count] - coupon[:num] # - used to be %
      end
    }
  }
  # binding.pry
  until array == []
    if cart[array[0]] == nil
      cart[array[0]] = {price: array[1], clearance: array[2], count: array[3]}
    else
      # cart[array[0]][:price] = cart[array[0]][:price] + array[1]
      cart[array[0]][:count] = cart[array[0]][:count] + array[3]
    end
    array.shift(4)
  end
  cart
end

def apply_clearance(cart)
  cart.each{ |prod, p_hash|
    # binding.pry
    if p_hash[:clearance]
      p_hash[:price]= (p_hash[:price] * 0.8).round(2)
    end
  }
  cart
end

def checkout(cart, coupons)
  # binding.pry
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each { |prod, p_hash|
    total += p_hash[:price]*p_hash[:count]
  }
  if total > 100
    total = (total*0.9).round(2)
  end
  total
end


#
# def checkout(cart, coupons)
#   # binding.pry
#   cart = consolidate_cart(cart)
#   if coupons != []
#     cart = apply_coupons(cart, coupons)
#   end
#   cart = apply_clearance(cart)
#   cart = consolidate_cart([cart])
#   total = 0
#   cart.each { |prod, p_hash|
#     total += p_hash[:price]
#   }
#   # binding.pry
#   if total > 100
#     total = (total*0.9).round(2)
#   end
#   total
# end
