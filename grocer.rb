require "pry"

def apply_coupons(cart, coupons)
  add_cart = {}
  puts  " all coupons " + coupons.to_s
  if coupons == []
    return cart
  end
  coupons.each do |coupon|
    puts
    puts "coupon before - " + coupon.to_s
    puts "cart before " + cart.to_s

    cart.each do |item_name, item_hash|
      if (coupon[:item] == item_name) && (item_hash[:count] >= coupon[:num])
        add_cart[item_name + " W/COUPON"] = {
                                            :price => coupon[:cost],
                                            :clearance => item_hash[:clearance],
                                            :count => (add_cart.include?(item_name + " W/COUPON")?
                                            (add_cart[item_name + " W/COUPON"][:count] += 1) : 1)
                                          }
        item_hash[:count] = item_hash[:count] - coupon[:num]
        coupon.delete(coupon[:item])
      end
    end #cart

    puts "coupon after - " + coupon.to_s
    puts "cart after " + cart.to_s
    puts "add_cart after " + add_cart.to_s

  end #coupon
  return cart.merge(add_cart)
end


def consolidate_cart(cart)
  uniq_hash = cart.uniq
  final_hash = {}

  uniq_hash.each do |item|

    item.values[0][:count] = 0
    final_hash[item.keys[0]] = item.values[0]
  end
  cart.each do |item|
    #binding.pry
    final_hash[item.keys[0]][:count] += 1
  end
  return final_hash
end



def apply_clearance(cart)
  cart.each do |item, item_hash|
    if item_hash[:clearance]
      item_hash[:price] = item_hash[:price]*80/100
    end
  end
end

def checkout(cart, coupons)
  puts cart
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  puts "after coupons " + cart.to_s

  cart = apply_clearance(cart)
  puts "after clearnce " + cart.to_s

  total = 0
  cart.each do |item, item_hash|
    total += item_hash[:price] * item_hash[:count]
  end
  if total > 100
    return total - total * 10/100
  end
  return total
end

#apply_coupons({"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>5}}, [{:item=>"AVOCADO", :num=>2, :cost=>5.0},
 #{:item=>"AVOCADO", :num=>2, :cost=>5.0}])
