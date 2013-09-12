#
# Cookbook Name:: iptables-ng
# Recipe:: manage
#
# Copyright 2013, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

ruby_block 'create_rules' do
  block do
    class Chef::Resource::RubyBlock
      include Iptables::Manage
    end

    [4, 6].each do |ip_version|
      create_iptables_rules(ip_version)
    end
  end

  action :nothing
end

ruby_block 'restart_iptables' do
  block do
    r = Chef::Resource::IptablesNgService.new('apply', run_context)
    r.run_action(:restart)
  end

  action :nothing
end
