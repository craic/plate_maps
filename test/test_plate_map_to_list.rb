#!/usr/bin/env ruby
#
# Unit Tests for the plate_map_to_list script

require 'test/unit'

class PlateMapToList < Test::Unit::TestCase
  
  def setup
    @test_dir      = File.dirname(__FILE__)
    @test_data_dir = File.join(@test_dir, 'data')
    @error_file  = File.join(@test_dir, 'tmpdir', 'error')
    @script      = File.join(@test_dir, '..', 'plate_map_to_list')  
  end

  # test the script from the command line level

  def test_basic_96_plate_file_csv_defaults
    input_file = File.join(@test_data_dir, 'map_two_plates.csv')
    # default arguments
    args = [ ]

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '1,A,1,1A1', lines[0]
    assert_equal '1,A,2,1A2', lines[1]
    assert_equal '2,H,11,95', lines[-2]
    assert_equal '2,H,12,96', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_row_major
    input_file = File.join(@test_data_dir, 'map_two_plates.csv')
    args = [ '--order', 'row_major']

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '1,A,1,1A1', lines[0]
    assert_equal '1,A,2,1A2', lines[1]
    assert_equal '2,H,11,95', lines[-2]
    assert_equal '2,H,12,96', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_column_major
    input_file = File.join(@test_data_dir, 'map_two_plates.csv')
    args = [ '--order', 'column_major']

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '1,A,1,1A1', lines[0]
    assert_equal '1,B,1,1B1', lines[1]
    assert_equal '2,G,12,84', lines[-2]
    assert_equal '2,H,12,96', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end
  
  def test_basic_96_plate_file_csv_row_major_output_csv
    input_file = File.join(@test_data_dir, 'map_two_plates.csv')
    args = [ '--order', 'row_major', '--format', 'csv']

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '1,A,1,1A1', lines[0]
    assert_equal '1,A,2,1A2', lines[1]
    assert_equal '2,H,11,95', lines[-2]
    assert_equal '2,H,12,96', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_row_major_output_tab
    input_file = File.join(@test_data_dir, 'map_two_plates.csv')
    args = [ '--order', 'row_major', '--format', 'tab']

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal "1\tA\t1\t1A1", lines[0]
    assert_equal "1\tA\t2\t1A2", lines[1]
    assert_equal "2\tH\t11\t95", lines[-2]
    assert_equal "2\tH\t12\t96", lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_input_tab
    input_file = File.join(@test_data_dir, 'map_two_plates.tab')
    # default arguments
    args = [ ]

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '1,A,1,1A1', lines[0]
    assert_equal '1,A,2,1A2', lines[1]
    assert_equal '2,H,11,95', lines[-2]
    assert_equal '2,H,12,96', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end


  def test_basic_384_plate_file_csv
    input_file = File.join(@test_data_dir, 'map_one_plate_384.csv')
    # default arguments
    args = [ '--plate', '384' ]

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 384, lines.length
    assert_equal '1,A,1,1A1', lines[0]
    assert_equal '1,A,2,1A2', lines[1]
    assert_equal '1,P,23,1P23', lines[-2]
    assert_equal '1,P,24,1P24', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_offset_plates
    # and this uses internal plate IDs
    input_file = File.join(@test_data_dir, 'map_two_plates_offset.csv')
    # default arguments
    args = [ ]

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '100,A,1,1A1', lines[0]
    assert_equal '100,A,2,1A2', lines[1]
    assert_equal '101,H,11,95', lines[-2]
    assert_equal '101,H,12,96', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_offset_with_empty_cells
    # and this uses internal plate IDs
    input_file = File.join(@test_data_dir, 'map_two_plates_offset_empty_cells.csv')
    # default arguments
    args = [ ]

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 192, lines.length
    assert_equal '100,A,1,1A1', lines[0]
    assert_equal '100,A,2,1A2', lines[1]
    assert_equal '101,H,11,95', lines[-2]
    assert_equal '101,H,12,',   lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

  def test_basic_96_plate_file_csv_offset_skip_empty_cells
    # and this uses internal plate IDs
    input_file = File.join(@test_data_dir, 'map_two_plates_offset_empty_cells.csv')
    # default arguments
    args = [ '--skip-empty' ]

    # Redirect the output to a string
    output = `#{@script} #{args.join(' ')} #{input_file} 2> #{@error_file}`

    assert_equal 0, File.size(@error_file)

    lines = Array.new
    output.each_line do |line|
      line.chomp!
      lines << line
    end
    assert_equal 162, lines.length
    assert_equal '100,A,1,1A1', lines[0]
    assert_equal '100,A,2,1A2', lines[1]
    assert_equal '101,H,11,95', lines[-1]
    
    File.delete(@error_file) if File.exists?(@error_file)
  end

end
