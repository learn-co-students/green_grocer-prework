require 'pry'
def consolidate_cart(cart)
  hash_w_rep=[]
  cart.each do |array1|
    hash_w_rep=(hash_w_rep.push(array1.keys)).flatten
    binding.pry
  end
 new_hash=cart.uniq
 new_hash.each do |array|
   array.each do |name, value|
      array[name][:count]=0
     end
   end
   
   new_hash.each do |array|
   array.each do |name, value|
     array[name][:count]+=hash_w_rep.count(name)
      
   end
 end

return new_hash
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
