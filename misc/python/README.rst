KaHIP Python Wrapper
====================

Installation
------------

::

	pip install kahipwrapper


Usage
-----

::

    from kahipwrapper import kaHIP

    vwgt = None
    xadj = [0,2,5,7,9,12]
    adjcwgt = [1,1,1,1,1,1,1,1,1,1,1,1]
    adjncy = [1,4,0,2,4,1,3,2,4,0,1,3]
    nparts = 2
    imbalance = 0.03
    suppress_output = False
    mode = kaHIP.STRONG
    seed = 0

    ncount = len(xadj) - 1
    nparts = 2

    print(ncount)

    print(kaHIP.kaffpa_balance_NE(ncount, vwgt, xadj, adjcwgt, adjncy,
                                  nparts, imbalance, suppress_output,
                                  seed, mode))
    print(kaHIP.kaffpa(ncount, vwgt, xadj, adjcwgt, adjncy, nparts,
                       imbalance, suppress_output, seed, mode))

    print(kaHIP.node_separator(ncount, vwgt, xadj, adjcwgt, adjncy, nparts,
                               imbalance, suppress_output, seed, mode))

For more information, please visit KaHIP site `here <http://algo2.iti.kit.edu/kahip/>`__


