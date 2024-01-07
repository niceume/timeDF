#include <Rcpp.h>

// [[Rcpp::export(.cpp_times_within_periods)]]
Rcpp::IntegerVector cpp_times_within_periods(Rcpp::NumericVector time_nums,
                                             Rcpp::NumericVector start_time_nums,
                                             Rcpp::NumericVector end_time_nums)
{
    int time_nums_len = time_nums.length();
    int periods_len = start_time_nums.length();
    Rcpp::IntegerVector result (time_nums_len, 0);
    for(int time_num_idx = 0; time_num_idx < time_nums_len; time_num_idx++){
        double time_num = time_nums[time_num_idx];
        for(int period_idx = 0; period_idx < periods_len; period_idx++){
            double start_num = start_time_nums[period_idx];
            double end_num = end_time_nums[period_idx];
            if( start_num <= time_num && time_num <= end_num){
                result[time_num_idx] = 1;
                break;
            }
        }
    }
    return result;
}
