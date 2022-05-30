#include <iostream>
#include "sort.h"
using namespace std;
int main() {
	cout << "Hello, world!" << endl;
	int a[10];
	cout << "original array:" << endl;
	for (int i = 0; i<10; i++) {
		a[i] = -2*i*i + 10*i +2;
		cout<<a[i] << " ";
	}
	cout<< endl;
	cout << "sorted array:" << endl;
	sort::shellsort(a, 10);
	for (int i=0; i<10; i++) {
		cout << a[i] << " ";
	}
	cout<<endl;
	
	exit(0);
}
