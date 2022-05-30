#include <iostream>
#include "sort.h"
namespace sort {
	void shellsort(int *a, int n) {
		for (int i=0; i < n-1; ++i) {
			int t = i;
			for (int j=i+1; j<n; ++j) {
				if (a[j] < a[t]) {
					t = j;
				}
			}
			if (t != i) {
				a[i] ^= a[t];
				a[t] ^= a[i];
				a[i] ^= a[t];
			}
		}
	}
};

