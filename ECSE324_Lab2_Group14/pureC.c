int main(){
	int a[5]={1,20,3,4,5};
	int max_val=a[0];
	int i=1;
	for(i=1;i<5;i++)
	{
		if(max_val<a[i]) //only switch if a[i] is bigger than max
		{
			max_val=a[i];
		}
	}
	return max_val;

}
