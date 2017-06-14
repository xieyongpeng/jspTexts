package com.helloweenvsfei.person;

public class Person {
	private String id;
	private String name;
	private int number;
	private int price;
	private String description;
	private int borrownumber=1;
	public void setId(String id){
		this.id=id;
	}
	public String getId(){
		return this.id;
	}
	public void setName(String name){
		this.name=name;
	}
	public String getName(){
		return this.name;
	}
	public void setNumber(int number){
		this.number=number;
	}
	public int getNumber(){
		return this.number;
	}
	public void setPrice(int price){
		this.price=price;
	}
	public int getPrice(){
		return this.price;
	}
	public void setDescription(String description){
		this.description=description;
	}
	public String getDescription(){
		return this.description;
	}
	public void setBorrownumber(int borrownumber){
		this.borrownumber=borrownumber;
	}
	public int getBorrownumber(){
		return this.borrownumber;
	}
}
