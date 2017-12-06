package hashMap;

/**
 * represents linked list data structure and related operations
 * @author 
 *
 * @param <K> key 
 * @param <V> value
 */
public class HashLinkedList<K,V>{
	
	/**
	 * data members
	 */
	private HashNode<K,V> head;
	private Integer size;

	/**
	 * creates an instance of {@link HashLinkedList}
	 */
	HashLinkedList(){
		head = null;
		size = 0;
	}

	/**
	 * Add (Hash)node at the front of the linked list
	 * @param key
	 * @param value
	 */
	public void add(K key, V value){
		HashNode<K,V> temp = head;
		while(head != null){
			if(head.getKey().equals(key)){
				head.setValue(value);
				return;
			}
			head = head.next;
		}
		size++;
		HashNode<K, V> newHashNode = new HashNode<>(key, value);
		newHashNode.next = temp;
		head = newHashNode;
	}

	/**
	 * Get Hash(node) by key
	 * @param key
	 * @return returns the node with key
	 */
	public HashNode<K,V> getListNode(K key){
		HashNode<K,V> temp = head;
		while(temp != null){
			if(temp.getKey().equals(key)){
				return temp;
			}
			temp = temp.next;
		}
		return null;
	}

	/**
	 * Remove the head node of the list
	 * Note: Used by remove method and next method of hash table Iterator
	 * @return first {@link HashNode} if exists otherwise returns null
	 */
	public HashNode<K,V> removeFirst(){
		HashNode<K,V> temp = head;
		if(head != null){
			if(head.next != null){
				head = head.next;
			}else{
				head = null;
			}
			size--;
		}	
		return temp; 
	}

	/**
	 * Remove Node by key from linked list 
	 * @param key
	 * @return {@link HashNode} if exists otherwise return null
	 */
	public HashNode<K,V> remove(K key){
		if(head != null){
			HashNode<K,V> current = head;
			if(head.getKey().equals(key)){
				head = head.next;
				size--;
				return current;
			}
			HashNode<K,V> previous = null;
			while( current != null && !current.getKey().equals(key)){
				previous = current;
				current = current.next;
			}
			
			if(current != null){
				size--;
				previous.next = current.next;
			}
		}
		return null;
	}

	/**
	 * Delete the whole linked list
	 */
	public void clear(){
		head = null;
		size = 0;
	}
	
	/**
	 * Check if the list is empty
	 * @return
	 */
	boolean isEmpty(){
		return size == 0? true:false;
	}

	/**
	 * 
	 * @return the size of linked list
	 */
	int size(){
		return this.size;
	}
	
	/**
	 * returns first {@link HashNode} in linked list
	 * @return
	 */
	public HashNode<K,V> getFirst(){
		return head;
	}
	
}