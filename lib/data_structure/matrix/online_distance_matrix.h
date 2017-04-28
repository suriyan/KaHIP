/******************************************************************************
 * online_distance_matrix.h 
 *
 * Source of KaHIP -- Karlsruhe High Quality Partitioning.
 *
 ******************************************************************************
 * Copyright (C) 2013-2015 Christian Schulz <christian.schulz@kit.edu>
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 *****************************************************************************/

#ifndef ONLINE_DISTANCE_MATRIX_DAUJ4JMM
#define ONLINE_DISTANCE_MATRIX_DAUJ4JMM

#include <vector>
#include <iostream>
#include "matrix.h"

class online_distance_matrix : public matrix {
public:
        online_distance_matrix(unsigned int dim_x, unsigned int dim_y) : m_dim_x (dim_x), 
                                                                         m_dim_y (dim_y) {
        };
        
        void setPartitionConfig( PartitionConfig & config ) {
                this->config = config;
                interval_sizes.resize(config.group_sizes.size());
                interval_sizes[0] = config.group_sizes[0]; 
                for( unsigned i = 1; i < interval_sizes.size(); i++) {
                        interval_sizes[i] = config.group_sizes[i]*interval_sizes[i-1];
                }
 
        }

        virtual ~online_distance_matrix() {};

        inline int get_xy(unsigned int x, unsigned int y) {
                //now depending on x and y, generate distance
                int k = config.group_sizes.size()-1;
                for(;k >= 0; k--) {
                        int interval_a = x / interval_sizes[k];
                        int interval_b = y / interval_sizes[k];
                        if( interval_a != interval_b ) {
                                break;
                        }
                }
                k++;

                return config.distances[k];
        };

        inline void set_xy(unsigned int x, unsigned int y, int value) {
                // do nothing -- matrix cannot be modified
        };

        inline unsigned int get_x_dim() {return m_dim_x;};
        inline unsigned int get_y_dim() {return m_dim_y;};

        void print() {
                for( unsigned int i = 0; i < get_x_dim(); i++) {
                        for( unsigned int j = 0; j < get_y_dim(); j++) {
                                std::cout <<  get_xy(i,j) << " ";
                        }
                        std::cout <<  ""  << std::endl;
                }
        }

private:
        PartitionConfig config;
        unsigned int m_dim_x, m_dim_y;
        std::vector< int > interval_sizes;

};


#endif /* end of include guard: NORMAL_MATRIX_DAUJ4JMM */
