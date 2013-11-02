# -*- coding: utf-8 -*-
#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "git"


dotfiles_d = node[:dotfiles][:directory].empty? ? "~#{node[:user][:name]}/.dotfiles" : node[:dotfiles][:directory]
dotfiles_d = File.expand_path(dotfiles_d)


git dotfiles_d do
  repository node[:dotfiles][:repository]
  user node[:user][:name]
  group node[:user][:group]
  action :sync
end

node[:dotfiles][:files].each do |file|

  link_path = File.expand_path("~#{node[:user][:name]}/#{file}")

  link link_path do
    owner node[:user][:name]
    group node[:user][:group]
    to "#{dotfiles_d}/#{file}"
  end
end
